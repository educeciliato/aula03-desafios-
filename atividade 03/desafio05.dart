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
  String nome;
  double preco;
  String lote;

  Produto({required this.nome, required this.preco, required this.lote});
}

class PedidoCompra {
  Produto produto;
  int quantidade;
  Fornecedor fornecedor;

  PedidoCompra({required this.produto, required this.quantidade, required this.fornecedor});

  Function verificarLote = (Produto produto) {
    return produto.lote.startsWith('A'); 
  };
}

class Cliente {
  String nome;
  Endereco endereco;

  Cliente({required this.nome, required this.endereco});
}

class PedidoVendaEntrega {
  Cliente cliente;
  Produto produto;
  int quantidade;

  PedidoVendaEntrega({required this.cliente, required this.produto, required this.quantidade});

  Function concluirVenda = (PedidoVendaEntrega pedido) {
    return pedido.quantidade > 0
        ? 'Venda concluída para ${pedido.cliente.nome}!'
        : 'Quantidade inválida para venda.';
  };

  Function organizarEntrega = (PedidoVendaEntrega pedido) {
    return 'Entrega agendada para ${pedido.cliente.nome} no endereço: ${pedido.cliente.endereco.rua}, ${pedido.cliente.endereco.cidade}.';
  };
}

class ArmazemEstoque {
  String nome;
  Endereco endereco;
  Map<Produto, int> estoque = {};

  ArmazemEstoque({required this.nome, required this.endereco});

  Function calcularRota = (Endereco enderecoCliente, Endereco enderecoArmazem) {
    return 'Calculando rota entre ${enderecoArmazem.cidade} e ${enderecoCliente.cidade}.';
  };

  void ajustarEstoque(Produto produto, int quantidade) {
    if (estoque.containsKey(produto) && estoque[produto]! >= quantidade) {
      estoque[produto] = estoque[produto]! - quantidade;
      print('Estoque ajustado: ${produto.nome} agora tem ${estoque[produto]} unidades.');
    } else {
      print('Estoque insuficiente para o produto ${produto.nome}.');
    }
  }
}

void main() {
  Endereco enderecoFornecedor = Endereco(rua: 'Av. Comercial', cidade: 'Curitiba', estado: 'PR', pais: 'Brasil');
  Fornecedor fornecedor = Fornecedor(nome: 'Distribuidora X', endereco: enderecoFornecedor);

  Produto produto = Produto(nome: 'Notebook', preco: 3000.0, lote: 'A123');

  PedidoCompra pedidoCompra = PedidoCompra(produto: produto, quantidade: 10, fornecedor: fornecedor);

  print(pedidoCompra.verificarLote(produto)
      ? 'Lote válido para ${produto.nome}.'
      : 'Lote inválido para ${produto.nome}.');

  Endereco enderecoCliente = Endereco(rua: 'Rua das Flores', cidade: 'São Paulo', estado: 'SP', pais: 'Brasil');
  Cliente cliente = Cliente(nome: 'João Silva', endereco: enderecoCliente);

  PedidoVendaEntrega pedidoVendaEntrega = PedidoVendaEntrega(cliente: cliente, produto: produto, quantidade: 5);

  print(pedidoVendaEntrega.concluirVenda(pedidoVendaEntrega));

  print(pedidoVendaEntrega.organizarEntrega(pedidoVendaEntrega));

  Endereco enderecoArmazem = Endereco(rua: 'Rua das Indústrias', cidade: 'Belo Horizonte', estado: 'MG', pais: 'Brasil');
  ArmazemEstoque armazem = ArmazemEstoque(nome: 'Central de Distribuição', endereco: enderecoArmazem);

  armazem.estoque[produto] = 20;

  armazem.ajustarEstoque(produto, 5);

  print(armazem.calcularRota(cliente.endereco, armazem.endereco));
}