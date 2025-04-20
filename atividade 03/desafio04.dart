class Endereco {
  String rua;
  String cidade;
  String estado;
  String pais;

  Endereco({required this.rua, required this.cidade, required this.estado, required this.pais});
}

class Produto {
  String tipo;
  String categoria;
  String unidadeMedida;
  String garantia;

  Produto({required this.tipo, required this.categoria, required this.unidadeMedida, required this.garantia});

  @override
  String toString() {
    return '$tipo - $categoria ($unidadeMedida) com garantia de $garantia';
  }
}

class Armazem {
  String nome;
  Endereco endereco;
  Map<Produto, int> estoque = {};
  List<String> historicoAlteracoes = [];

  Armazem({required this.nome, required this.endereco});

  void adicionarProduto(Produto produto, int quantidade) {
    if (estoque.containsKey(produto)) {
      estoque[produto] = estoque[produto]! + quantidade;
    } else {
      estoque[produto] = quantidade;
    }
    registrarHistorico('Adicionado: $quantidade unidades de ${produto.tipo}.');
  }

  void venderProduto(Produto produto, int quantidade) {
    if (estoque.containsKey(produto) && estoque[produto]! >= quantidade) {
      estoque[produto] = estoque[produto]! - quantidade;
      registrarHistorico('Vendido: $quantidade unidades de ${produto.tipo}.');
    } else {
      print('Estoque insuficiente para ${produto.tipo}!');
    }
  }

  void registrarHistorico(String mensagem) {
    String dataHora = DateTime.now().toString();
    historicoAlteracoes.add('[$dataHora] $mensagem');
  }

  void exibirHistorico() {
    print('Histórico de Alterações no Estoque:');
    historicoAlteracoes.forEach(print);
  }

  void exibirEstoque() {
    print('Estoque Atual do Armazém $nome:');
    estoque.forEach((produto, quantidade) {
      print('${produto.tipo}: $quantidade unidades');
    });
  }
}

void main() {
  Endereco enderecoArmazem = Endereco(
    rua: 'Rua das Indústrias',
    cidade: 'Belo Horizonte',
    estado: 'MG',
    pais: 'Brasil',
  );

  Armazem armazem = Armazem(nome: 'Central de Distribuição', endereco: enderecoArmazem);

  Produto produto1 = Produto(tipo: 'Notebook', categoria: 'Eletrônicos', unidadeMedida: 'Unidade', garantia: '2 anos');
  Produto produto2 = Produto(tipo: 'Geladeira', categoria: 'Eletrodomésticos', unidadeMedida: 'Unidade', garantia: '5 anos');

  armazem.adicionarProduto(produto1, 10);
  armazem.adicionarProduto(produto2, 5);

  armazem.exibirEstoque();

  armazem.venderProduto(produto1, 3);
  armazem.venderProduto(produto2, 2);

  armazem.exibirEstoque();

  armazem.exibirHistorico();
}