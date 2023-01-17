//
//  FiglioViewController.swift
//  formazione
//
//  Created by Giovanni Rossi Borrelli on 10/01/23.
//

import UIKit

class FiglioViewController: UIViewController {
    
    @IBOutlet weak var datiRicevutiUILabel: UILabel!
    
    
    var datiDaPadre=""
    
    var datiDaInviareAlPadre = "Dati"

    override func viewDidLoad() {
        super.viewDidLoad()
        datiRicevutiUILabel?.text = datiDaPadre
        //Questo si base sul le linee guide dei protocolli
        //se vogliamo utlizzare i metodi del protocollo
        //occorre dire che questa ViewController ne fa il delegato
        //quindi osserva le funzioni
    }
    
    @IBAction func tornaIndietroAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BtoAUnwind", sender: self)
    }

}


//Se stiamo utilizzando il NavigationController
//Per effettuare il passaggio di dati da Figlio a padre
//possiamo utilizzare questo delegate.
/*
extension FiglioViewController:UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //Passaggio di dati che funziona solo se utilizziamo
        //IL navigationController
        if viewController is ViewController{
            let padreVC = viewController as! ViewController
            padreVC.datiRicevuti = "Dati Da Delegate"
        }
       
    }
    
}
*/
