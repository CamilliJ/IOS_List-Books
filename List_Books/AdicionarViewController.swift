//
//  AdicionarViewController.swift
//  List_Books
//
//  Created by COTEMIG on 04/07/22.
//

import UIKit

protocol AdicionarViewControllerDelegate:AnyObject {
    func salvarbtn(livro: Livro)
}

class AdicionarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        descricaolivro.layer.borderWidth = 1
        descricaolivro.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBOutlet weak var nomelivro: UITextField!
    @IBOutlet weak var imagemlivro: UITextField!
    @IBOutlet weak var precolivro: UITextField!
    @IBOutlet weak var descricaolivro: UITextView!
    
    weak var delegate: AdicionarViewControllerDelegate?
    
    
    @IBAction func salvarbtn(_ sender: Any) {
        let titulo = nomelivro.text ?? ""
        let imagem = imagemlivro.text ?? ""
        let preco = precolivro.text ?? ""
        let descricao = descricaolivro.text ?? ""
        
        if titulo.isEmpty || imagem.isEmpty || preco.isEmpty || descricao.isEmpty  {
            let dialog = UIAlertController(title: "Error", message: "Preencha todos os campos", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "Ok", style: .default))
            present(dialog, animated: true)
        }else{
            let livro = Livro(id: "",titulo: titulo, imagem: imagem, preco: preco, description: descricao)
            delegate?.salvarbtn(livro: livro)
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    

}
