class Endereco {
  String rua;
  String cidade;
  String estado;
  String pais;

  Endereco({required this.rua, required this.cidade, required this.estado, required this.pais});
}

class Fornecedor {
  String nome;
  Endereco endereco;

  Fornecedor({required this.nome, required this.endereco});
}

class Produto {
  String tipo;
  String categoria;
  String unidadeMedida;

  double preco;

  Produto({required this.tipo, required this.categoria, required this.unidadeMedida, required this.preco});
}

class PedidoCompra {
  Produto produto;
  int quantidade;
  Fornecedor fornecedor;

  PedidoCompra({required this.produto, required this.quantidade, required this.fornecedor});

  Function calcularFrete = (int distancia, int quantidade) => distancia * 0.5 + quantidade * 2.0;

  Function realizarPagamento = () {
    return (PedidoCompra pedido) {
      double total = pedido.produto.preco * pedido.quantidade;
      DateTime dataPagamento = DateTime.now();

      print('Pagamento realizado com sucesso!');
      print('Fornecedor: ${pedido.fornecedor.nome}');
      print('Produto: ${pedido.produto.tipo}');
      print('Quantidade: ${pedido.quantidade}');
      print('Total: R\$ ${total.toStringAsFixed(2)}');
      print('Data do pagamento: $dataPagamento');
    };
  };
}

void main() {
  Endereco enderecoFornecedor = Endereco(
    rua: 'Av. Comercial',
    cidade: 'Curitiba',
    estado: 'PR',
    pais: 'Brasil',
  );

  Fornecedor fornecedor = Fornecedor(nome: 'Distribuidora X', endereco: enderecoFornecedor);
  Produto produto = Produto(tipo: 'Bebida', categoria: 'Suco', unidadeMedida: 'Litro', preco: 6.5);
  PedidoCompra pedido = PedidoCompra(produto: produto, quantidade: 20, fornecedor: fornecedor);

  double frete = pedido.calcularFrete(100, pedido.quantidade); // Simulando distância de 100 km
  print('Valor do frete: R\$ ${frete.toStringAsFixed(2)}');

  pedido.realizarPagamento()(pedido);
}
