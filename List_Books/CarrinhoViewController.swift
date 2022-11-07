//
//  CarrinhoViewController.swift
//  List_Books
//
//  Created by COTEMIG on 24/10/22.
//

import UIKit

class CarrinhoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var carrinho : [Livro] = [ Livro(titulo: "Rainha Vermelha | 1º Volume", imagem: "https://images-na.ssl-images-amazon.com/images/I/71-gOnTKuOL.jpg", preco: "R$33,90", description: "Mare e sua família são vermelhos: plebeus, humildes, destinados a servir uma elite prateada cujos poderes sobrenaturais os tornam quase deuses. Mare rouba o que pode para ajudar sua família a sobreviver e não tem esperanças de escapar do vilarejo miserável onde mora.")]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        if let listaDeLivros = UserDefaults.standard.value(forKey: "ListaLivro") as? Data {
            let livro = try! JSONDecoder().decode([Livro].self, from: listaDeLivros)
            
            carrinho.append(contentsOf: livro)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrinho.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ViewCell
        cell.NomeLivro?.text = carrinho[indexPath.row].titulo
        cell.PrecoLivro?.text = carrinho[indexPath.row].preco
        cell.DescripitonLivro?.text = carrinho[indexPath.row].description
        
        let loading = UIActivityIndicatorView(style: .medium)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        loading.hidesWhenStopped = true
        
        cell.ImageLivro.addSubview(loading)
        
        cell.ImageLivro.addConstraints([
            loading.centerYAnchor.constraint(equalTo: cell.ImageLivro.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: cell.ImageLivro.centerXAnchor),
        ])
        
        let url = URL(string: carrinho[indexPath.row].imagem)!
        getImage(from: url) { image in
            
            DispatchQueue.main.async {
                cell.ImageLivro?.image = image
                loading.stopAnimating()
            }
            
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
