//
//  SegundaViewController.swift
//  List_Books
//
//  Created by COTEMIG on 27/06/22.
//

import UIKit

protocol Atualizar {
    func btnEditar(livro: editar)
    
}

class SegundaViewController: UIViewController {
    
    var livro: editar? = nil
    var delegate : Atualizar?
    var Livro: Livro?
    
    var carrinho : [Livro] = []

    
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var preco: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let livro = livro{
            nome.text = livro.livro.titulo
            preco.text = "R$" + livro.livro.preco
            descricao.text = livro.livro.description
            let url = URL(string: livro.livro.imagem)!
            getImage(from: url) { imagem in
                
                DispatchQueue.main.async {
                    self.image.image = imagem
                }
                
            }
            
        }
        
        
        
    }
    
    @IBAction func addCarrinho(_ sender: Any) {
        
        
        
        //let listaCarrinho = try! JSONEncoder().encode(carrinho)
        //UserDefaults.standard.set(listaCarrinho, forKey: "ListaCarrinho")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let livro = sender as? editar{
            let viewController = segue.destination as! EditarViewController
            viewController.livro = livro
            viewController.delegate = self
        }
    }
    
    @IBAction func Editar(sender: Any?) {
        performSegue(withIdentifier: "editar", sender: livro)
    }
 
    
    


}
extension SegundaViewController: EditarViewControllerDelegate{
    func btnEditar(livro: editar) {
        self.livro = livro
        delegate?.btnEditar(livro: livro)
        navigationController?.popViewController(animated: true)
    }
    
    
}
