//
//  EditarViewController.swift
//  List_Books
//
//  Created by COTEMIG on 08/08/22.
//

import UIKit

protocol EditarViewControllerDelegate:AnyObject {
    func btnEditar(livro: editar)
}

class EditarViewController: UIViewController {

    var livro: editar? = nil

    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtImagem: UITextField!
    @IBOutlet weak var txtPreco: UITextField!
    @IBOutlet weak var txtDescricao: UITextView!
    
    weak var delegate: EditarViewControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDescricao.layer.borderWidth = 1
        txtDescricao.layer.borderColor = UIColor.lightGray.cgColor
        txtTitulo.text = livro?.livro.titulo ?? "ERRO"
        txtImagem.text = livro?.livro.imagem ?? "ERRO"
        txtPreco.text = livro?.livro.preco ?? "ERRO"
        txtDescricao.text = livro?.livro.description ?? "ERRO"
        
    }
    
    @IBAction func btnEditar(_ sender: Any) {
        let titulo = txtTitulo.text ?? ""
        let imagem = txtImagem.text ?? ""
        let preco = txtPreco.text ?? ""
        let descricao = txtDescricao.text ?? ""
        
        let livroEditar = editar(livro: Livro(id: self.livro?.livro.id ,titulo: titulo, imagem: imagem, preco: preco, description: descricao) , index: livro!.index)
        delegate?.btnEditar(livro: livroEditar)
        
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    

}
