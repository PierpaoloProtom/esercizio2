//
//  DelegateViewController.swift
//  formazione
//
//  Created by Giovanni Rossi Borrelli on 11/01/23.
//

import UIKit

class DelegateViewController: UIViewController {
    
    @IBOutlet weak var campoUITextField: UITextField!
    
    @IBOutlet weak var mostraValoriTableView: UITableView!
    
    var valori:[String] = []
    
    var valoreDaInviare = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //I protocolli ci permettono di ascoltare le interazione
        //dell'oggetto grafico, in questo caso TableView e TextField
        
        //Tuttavia può essere generalizzato anche con gli oggetti
        //creati da noi come una classe o un oggetto grafico personalizzato.
        
        
        //Per ascoltare queste interazioni, ogni oggetto grafico
        //ha una variabile chiamata comunemente delegate.
        
        //Il delegate è un modo che ha l'oggetto grafico per dire
        //"Ehi qualcuno mi ha toccato, delegate pensaci tu"
        
        campoUITextField.delegate = self
        
        mostraValoriTableView.delegate = self
        
        //la table view oltre al delegate ha bisogno di
        //altri "delegati" che gli dicono come deve struttarsi
        mostraValoriTableView.dataSource = self
        
       
    }
    
}


//Linea guida di APPLe

//Ogni volta che il nostro ViewController deve fare da delegato
//deve creare delle estensioni

//Nel nostro caso DelegateViewController fa da delegato su 3 cose:
//1) TexField interazioni
//2) TableView struttura
//3) TableView Interazioni

extension DelegateViewController: UITextFieldDelegate{
    
    //Ci dice quanto utente preme sulla tastiera il tasto invio
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let testo = textField.text{
            self.valori.append(testo)
            //Dobbiamo aggiornare la tabella
            self.mostraValoriTableView.reloadData()
            //quando viene eseguito il reloadData, viene richiamato
            //i metodi del delegato DataSource
            //tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            //tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        }
        //Puliamo quanto scritto precedentemente
        textField.text = ""
        //Chiudiamo la tastiera
        textField.endEditing(true)
        //Valida valori
        return true
    }
    
    
}


extension DelegateViewController: UITableViewDataSource{
    //Mi chiede di definire quante righe è costituita la mia tabella.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valori.count
    }
    //Mi chiede di definire che aspetto ha la mia riga.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Se il nostro viewController ha tante tableView
        //occorre dire a quale si riferisce
        if tableView == self.mostraValoriTableView{
            //indexPath è un oggetto che all'interno ha il numero di righe
            //per sezione
            //indexPath.section
            //per riga
            //indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "valore", for: indexPath)
            //la cella in questo caso abbiamo usato quella di default
            cell.textLabel?.text = valori[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
        
    }

}


extension DelegateViewController: UITableViewDelegate{
    
    //esegui un azione quando la riga viene selezionata
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valore = self.valori[indexPath.row]
        self.valoreDaInviare = valore
        self.performSegue(withIdentifier: "tornaEx1", sender: self)
    }
    
}





