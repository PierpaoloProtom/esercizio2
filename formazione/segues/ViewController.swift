//
//  ViewController.swift
//  formazione
//
//  Created by Giovanni Rossi Borrelli on 10/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    var datiRicevuti=""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func eseguiModalAction(_ sender: UIButton) {
        //Viene utilizzato per presentare informazioni veloci
        let viewController = FiglioViewController()
        viewController.datiDaPadre = "EseguiModal"
        self.present(viewController, animated: true)
    }
    
    
    @IBAction func eseguiPerform(_ sender: UIButton) {
        //Si metti identificativo della freccia e come sender, il viewController che lo richiama
        self.performSegue(withIdentifier: "AtoBPerform", sender: self)
    }
    
    //Effettuiamo unwind
    //Si crea un pulsante vuoto (senza Collegamenti)
    //Che però nella sua firma, ha il segue: UIStoryboardSegue
    @IBAction func tornaIndietroUnwind(segue:UIStoryboardSegue){
        //Il figlio richiama questo metodo
        if segue.source is FiglioViewController{
            //Effettuiamo il casting
            let figlioVC = segue.source as! FiglioViewController
            //Passaggio di dati
            self.datiRicevuti = figlioVC.datiDaInviareAlPadre
        }
        
        if segue.source is DelegateViewController{
            let delegate = segue.source as! DelegateViewController
            print(delegate.valoreDaInviare)
        }
    }
    
    
    @IBAction func eseguiNavProgrammaticaAction(_ sender: UIButton) {
        
        //Vedremo più avanti che a volte occorre collegare
        //delle viewController che non sono collegati
        
        //A volte fanno parte di diversi tipi di storyboard.
        
        
        //Ci sono 2 possibili richiami.
        
        //1) Eseguito dentro una UIViewController (come in questo caso)
        
        //2) Eseguito dentro una classe, che non è una UIVIewController
        //nè una sua figlia
        
        //I casi si distinguono dal modo in cui si recupera
        //oggetto di tipo UIWindow che praticamente corrisponde
        //al padre di tutte le View, con questo oggetto possiamo
        //dire chi è la viewController radice.
        
        //1 Modo:
        guard let windowByVC = self.view.window else{
            print("non siamo riusciti a recuperare UIWindow")
            return
        }
        
        //2 Modo:
        //si utilizza UIApplication che corrisponde all'app
        //UIApplication.shared.windows le finestre totali dell'app
        //.first(where: \.isKeyWindow)  recupera la radice, la prima
        guard let windowByApplication = UIApplication.shared.windows.first(where: \.isKeyWindow) else {
            print("non siamo riusciti a recuperare UIWindow")
            return
        }
        
        //Eseguo la navigazione
        
        //Utilizzo lo storyboard padre, cioè il file storyboard
        let main = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        //tramite main instanzio la viewController che voglio
        //in base all'identificativo dato nello storyboard
        let figlioVC = main.instantiateViewController(withIdentifier: "ex2") as! FiglioViewController
        
        //passaggio dati
        figlioVC.datiDaPadre = "Nav prog"
        
        
        //poi gli dico chi è il navigationController
        let nav = UINavigationController(rootViewController: figlioVC)
        
        //Animazione di come deve essere mostrato
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        
        //Chi deve essere visualizzato
        windowByVC.rootViewController?.present(nav, animated: true)
        
    }
    
    
    @IBAction func vaiNelDelegato(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "vaiEx2", sender: self)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //attraverso il segue, sappiamo quale freccia è stata chiamata
        //con identifier
        if segue.identifier == "AtoBPerform"{
            //e poi con il segue sappiamo quale è la sua destinazione
            if segue.destination is FiglioViewController{
                //eseguo il casting as
                let figlioVc = segue.destination as! FiglioViewController
                //Effettuo il passaggio di dati da Padre a Figlio
                figlioVc.datiDaPadre = "Dati da Perform"
                return
            }
        }
        if segue.identifier == "AtoBButton"{
            if segue.destination is FiglioViewController{
                let figlioVc = segue.destination as! FiglioViewController
                figlioVc.datiDaPadre = "Dati da Button"
                return
            }
        }
        
    }
    
    
    


}

