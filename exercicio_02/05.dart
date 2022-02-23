main(){
  
 Pessoa p1 = Pessoa.inicialized("emanuel", "vitor");
  
 print(p1.nome);
 print("-----");
  
 Funcionario f1 = Funcionario.pessoa("joao", "marcos");
  
 Funcionario f2 = Funcionario.basic(123456, 1000.0);
  
 Funcionario f3 = Funcionario.complete("marta", "pereira", 432413, 23432.0);
 
 print(f1.nome);
 print(f1.sobreNome);
 print("-----");
 print(f2.matricula);
 print(f2.salario);
 print("-----");
 print(f3.nome);
 print(f3.sobreNome);
 print(f3.matricula);
 print(f3.salario);
 
}

class Pessoa {
	String _nome = "";
	String _sobreNome = "";
	
	Pessoa(){
    ;
	}
	
	Pessoa.inicialized(String nome, String sobreNome){
		_nome = nome;
		_sobreNome = sobreNome;
	}
	
	set nome(String nome) {
		_nome = nome;
	}
	
	set sobreNome(String sobreNome) {
		_sobreNome = sobreNome;
	}
	
	String get nome {
		return _nome;
	}
	
	String get sobreNome {
		return _sobreNome;
	}
	
	String getNomeCompleto() {
		return _nome + " " + _sobreNome;
	}
}

class Funcionario extends Pessoa{
	int _matricula = 0;
	double _salario = 0;
  
  Funcionario(){
    ;
  }
  
  Funcionario.basic(int matricula, double salario){
    _matricula = matricula;
    _salario = salario;
  }
  
  Funcionario.pessoa(String nome, String sobrenome){
    _nome = nome;
    _sobreNome = sobrenome;
  }
  
  Funcionario.complete(String nome, String sobrenome, int matricula, double salario){
    _matricula = matricula;
    _salario = salario;
    _nome = nome;
    _sobreNome = sobrenome;
  }
	
	void setMatricula(int matricula) {
		_matricula = matricula;
	}
	
	void setSalario(double salario) {
		if(salario < 0) {
			print("O salário não pode ser negativo.");
		} else {
			_salario = salario;
		}
	}
	
	int get matricula {
		return _matricula;
	}
	
	double get salario {
		return _salario;
	}
	
	double getSalarioPrimeiraParcela() {
		return _salario * 0.6;
	}
	
	double getSalarioSegundaParcela() {
		return _salario * 0.4;
	}
}

class Professor extends Funcionario {
	String _titulacao = "";
  
  Professor(){
    ;
  }
  
  Professor.basic(String titulacao) {
    _titulacao = titulacao;
  }
  
  Professor.pessoa(String nome, String sobrenome){
    _nome = nome;
    _sobreNome = sobrenome;
  }
  
  Professor.complete(String nome, String sobrenome, int matricula, double salario){
    _matricula = matricula;
    _salario = salario;
    _nome = nome;
    _sobreNome = sobrenome;
  }
	
	void setTitulacao(String titulacao) {
		_titulacao = titulacao;
	}
	
	String get titulacao {
		return _titulacao;
	}
}