//
//  ViewController.swift
//  List_Books
//
//  Created by COTEMIG on 27/06/22.
//

import UIKit
struct Livro : Codable {
    let id: String?
    let titulo: String
    let imagem: String
    let preco: String
    let description: String
}
 
struct editar  : Codable {
    var livro : Livro
    var index: Int
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    

    @IBOutlet weak var tableView: UITableView!

    
    
    var arrayLivros : [Livro] = []
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Chamando a função que lista os livros da API
        getApi()
        
    }
    
    
    // Listando os livros da API
    func getApi(){
        guard let url = URL(string: "https://635fd0e03e8f65f283bc3cdc.mockapi.io/books") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                // converter para um array de book -> [Book]
                let livros = try! JSONDecoder().decode([Livro].self, from: data)
                DispatchQueue.main.async {
                    self.arrayLivros = livros
                    self.tableView.reloadData()
                    print(livros)
                }
                
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLivros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ViewCell
        cell.NomeLivro?.text = arrayLivros[indexPath.row].titulo
        cell.PrecoLivro?.text = "R$" + arrayLivros[indexPath.row].preco
        cell.DescripitonLivro?.text = arrayLivros[indexPath.row].description
        
        let loading = UIActivityIndicatorView(style: .medium)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        loading.hidesWhenStopped = true
        
        cell.ImageLivro.addSubview(loading)
        
        cell.ImageLivro.addConstraints([
            loading.centerYAnchor.constraint(equalTo: cell.ImageLivro.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: cell.ImageLivro.centerXAnchor),
        ])
        
        let url = URL(string: arrayLivros[indexPath.row].imagem)!
        getImage(from: url) { image in
            
            DispatchQueue.main.async {
                cell.ImageLivro?.image = image
                loading.stopAnimating()
            }
            
        }
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProximaTela" {
            let livroSelecionado = sender as! editar
            let viewController = segue.destination as! SegundaViewController
            viewController.livro = livroSelecionado
            viewController.delegate = self
        } else if segue.identifier == "new"{
            let viewController = segue.destination as! AdicionarViewController
            viewController.delegate = self
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let livro = editar(livro: arrayLivros[indexPath.row], index: indexPath.row)        
        performSegue(withIdentifier: "ProximaTela", sender: livro)
            
    }
    
    
    
}

extension ViewController:AdicionarViewControllerDelegate{
    func salvarbtn(livro:Livro) {
        
        guard let url = URL(string: "https://635fd0e03e8f65f283bc3cdc.mockapi.io/books") else {
            return
        }
        
        var request = URLRequest(url: url)
        let value = try! JSONEncoder().encode(livro)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = value
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            if error != nil {
                return print(error?.localizedDescription ?? "")
            }else {
                self.getApi()
            }
            
        }.resume()
        
        self.tableView.reloadData()
       
    }
    
}

extension ViewController: Atualizar{
    func btnEditar(livro: editar) {
        
        guard let url = URL(string: "https://635fd0e03e8f65f283bc3cdc.mockapi.io/books/\(livro.livro.id!)") else {
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let value = try! JSONEncoder().encode(livro.livro)
        
        // Informando o dado que será enviado ao servidor
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        request.httpBody = value
    
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in


            if error != nil {
                return print(error?.localizedDescription ?? "")
            }else {
                self.getApi()
            }

        }.resume()
        
        
        
    }
}


extension UIViewController {
    func getImage(from url: URL, completion: @escaping ((UIImage?) -> Void)) {
        URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            if let error = error {
                print("error:  \(error)")
            }
            
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
    
}

