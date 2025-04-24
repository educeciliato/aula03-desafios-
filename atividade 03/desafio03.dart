class Endereco {
  String rua;
  String cidade;
  String estado;
  String pais;

  Endereco({required this.rua, required this.cidade, required this.estado, required this.pais});
}

class Funcionario {
  String nome;
  String cargo;
  double salario;

  Funcionario({required this.nome, required this.cargo, required this.salario});

  Function calcularBonus = () {
    return (Funcionario funcionario) {
      double bonus = funcionario.cargo == 'Gerente' ? funcionario.salario * 0.2 : funcionario.salario * 0.1;
      return bonus;
    };
  };
}

class Departamento {
  String nome;
  List<Funcionario> funcionarios;

  Departamento({required this.nome, required this.funcionarios});

  void gerarRelatorio() {
    print('Relatório do Departamento: $nome');
    funcionarios.forEach((funcionario) {
      double bonus = funcionario.calcularBonus()(funcionario);
      print('Funcionário: ${funcionario.nome}, Cargo: ${funcionario.cargo}, Salário: R\$ ${funcionario.salario.toStringAsFixed(2)}, Bônus: R\$ ${bonus.toStringAsFixed(2)}');
    });
  }
}

class Empresa {
  String nome;
  Endereco endereco;
  List<Departamento> departamentos;

  Empresa({required this.nome, required this.endereco, required this.departamentos});

  double calcularFolhaPagamento() {
    double total = 0.0;
    departamentos.forEach((departamento) {
      departamento.funcionarios.forEach((funcionario) {
        double bonus = funcionario.calcularBonus()(funcionario);
        total += funcionario.salario + bonus;
      });
    });
    return total;
  }
}

void main() {
  Endereco enderecoEmpresa = Endereco(
    rua: 'Av. Principal',
    cidade: 'São Paulo',
    estado: 'SP',
    pais: 'Brasil',
  );

  Funcionario funcionario1 = Funcionario(nome: 'Alice', cargo: 'Analista', salario: 4000.0);
  Funcionario funcionario2 = Funcionario(nome: 'Carlos', cargo: 'Gerente', salario: 7000.0);
  Funcionario funcionario3 = Funcionario(nome: 'Beatriz', cargo: 'Analista', salario: 4500.0);

  Departamento departamentoTI = Departamento(nome: 'TI', funcionarios: [funcionario1, funcionario2]);
  Departamento departamentoRH = Departamento(nome: 'RH', funcionarios: [funcionario3]);

  Empresa empresa = Empresa(nome: 'TechCorp', endereco: enderecoEmpresa, departamentos: [departamentoTI, departamentoRH]);

  empresa.departamentos.forEach((departamento) {
    departamento.gerarRelatorio();
    print('--------------------------');
  });

  double folhaTotal = empresa.calcularFolhaPagamento();
  print('Folha de pagamento total da empresa: R\$ ${folhaTotal.toStringAsFixed(2)}');
}
