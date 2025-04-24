class Endereco {
  String rua;
  String cidade;
  String estado;
  String pais;

  Endereco({required this.rua, required this.cidade, required this.estado, required this.pais});
}

class Cliente {
  String nome;
  Endereco endereco;

  Cliente({required this.nome, required this.endereco});
}

class Fornecedor {
  String nome;
  Endereco endereco;

  Fornecedor({required this.nome, required this.endereco});
}

class Produto {
  String nome;
  double preco;
  Fornecedor fornecedor;

  Produto({required this.nome, required this.preco, required this.fornecedor});
}

class Venda {
  Cliente cliente;
  Produto produto;

  Venda({required this.cliente, required this.produto});

  Function calcularImposto = (double preco) => preco * 0.1;

  Function concluirVenda = () {
    return (Venda venda) {
      if (venda.cliente.endereco.pais != venda.produto.fornecedor.endereco.pais) {
        print('Venda inválida! O produto não pode ser vendido em outro país.');
      } else {
        double imposto = venda.calcularImposto(venda.produto.preco);
        double total = venda.produto.preco + imposto;
        print('Venda realizada com sucesso!');
        print('Cliente: ${venda.cliente.nome}');
        print('Produto: ${venda.produto.nome}');
        print('Total (com imposto): R\$ ${total.toStringAsFixed(2)}');
      }
    };
  };
}

void main() {
  Cliente cliente = Cliente(
    nome: 'João Silva',
    endereco: Endereco(rua: 'Rua das Flores', cidade: 'São Paulo', estado: 'SP', pais: 'Brasil'),
  );

  Fornecedor fornecedor = Fornecedor(
    nome: 'Empresa Tech',
    endereco: Endereco(rua: 'Av. Central', cidade: 'Rio de Janeiro', estado: 'RJ', pais: 'Brasil'),
  );

  Produto produto = Produto(nome: 'Notebook', preco: 3500.0, fornecedor: fornecedor);
  Venda venda = Venda(cliente: cliente, produto: produto);
  venda.concluirVenda()(venda);
}
