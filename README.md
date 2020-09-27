# Disciplina: Base de Dados
Repositório com os arquivos para a avaliação continuada da disciplina Base de Dados, ministrada remotamente na Escola de Matemática Aplicada (EMAp) pelo professor Renato Souza. 

A avaliação é dividida em duas partes. Em um momento inicial, tínhamos de mapear um conjunto de dados e realizar sua modelagem, gerando, enfim, um dump em formato SQL. Nesse sentido, escolhemos os dados do projeto [What's on the menu?](https://data.world/data-society/discover-the-menu), em que foram catalogados os menus de restaurantes ocidentais de 1850 a 2015. Os modelos conceitual, lógico (que foi construído com o [Vertabelo](https://www.vertabelo.com/)) e físico (construído no [workbench do MySQL](https://dev.mysql.com/downloads/workbench/)) estão nas Figuras 1, 2 e 3, respectivamente; alternativamente, estão na pasta [models](https://github.com/tdsh-ux/dataBases/tree/master/models).  


A partir da base de dados, a organização do repositório é a seguinte: em [data](https://github.com/tdsh-ux/dataBases/tree/master/data), estão as bases de dados brutas (para o push, foi utilizado o [Git Large File Storage](https://git-lfs.github.com/)). Em [RScriptsCleaning](https://github.com/tdsh-ux/dataBases/tree/master/RScriptsCleaning), estão os scripts em R para [download](https://github.com/tdsh-ux/dataBases/blob/master/RScriptsCleaning/dishScript.R) e [limpeza](https://github.com/tdsh-ux/dataBases/blob/master/RScriptsCleaning/menuScript.R) dos dados. As tabelas preparadas, então, estão em [modelData](https://github.com/tdsh-ux/dataBases/tree/master/modelData). Em seguida, foi utilizado, conforme está em [PythonScriptsToSQL](https://github.com/tdsh-ux/dataBases/tree/master/PythonScriptsToSQL), um [notebook](https://github.com/tdsh-ux/dataBases/blob/master/PythonScriptsToSQL/dumpScript.ipynb) de Python para inserir os dados na base de dados MySQL e gerar o dump em formato SQL. Este, enfim, foi inserido em [dump](https://github.com/tdsh-ux/dataBases/blob/master/PythonScriptsToSQL/dumpScript.ipynb). 

### Descrição das Tabelas
+ <b>Menu:</b> A tabela principal da base de dados, contendo os dados do arquivo [Menu.csv](https://data.world/data-society/discover-the-menu/workspace/file?filename=Menu.csv). Os dados que precisavam de normalização foram colocados nas tabelas descritas a seguir:
  + <b>Event:</b> Tabela que descreve o tipo de evento no qual o menu foi usado (exemplos de dados: dinner, lunch, breakfasst, annual banquet, daily menu);
  + <b>Venue:</b> Motivação do evento (exemplos de dados: commercial, social);
  + <b>Currency:</b> Moeda utilizada nos preços dos pratos do menu;
  + <b>Sponsor:</b> Restaurante/entidade que promoveu o evento no qual o menu foi utilizado;
+ <b>Menu Page:</b> Tabela que descreve a página do menu, contendo seu número e alguns atributos físicos da mesma. Contém os dados do arquivo [MenuPage.csv](https://data.world/data-society/discover-the-menu/workspace/file?filename=MenuPage.csv);
+ <b>Dish:</b> Tabela contendo os pratos e suas respectivas descrições. Contém os dados do arquivo [Dish.csv](https://data.world/data-society/discover-the-menu/workspace/file?filename=Dish.csv); e
+ <b>Menu Item:</b> Tabela contendo os itens de cada menu. Recebe as fks de menu_page e menu_item de modo a indicar quais receitas estavam presentes em cada página do menu. Contém os dados do arquivo [MenuItem.csv](https://data.world/data-society/discover-the-menu/workspace/file?filename=MenuItem.csv).

Haviam colunas do arquivo Menu.csv que eram possíveis de ser obtidas com script, portanto foram criadas duas views que possuem os joins necessários para mostrar os dados das mesmas sem que fossem registrados:
   + <b>View 1: page_count:</b> view equivalente ao registro page_count da tabela menu, mostrando quantas páginas cada menu possui; e
   + <b>View 1: dish_count:</b> view equivalente ao registro dish_count da tabela menu, mostrando quantas receitas cada menu possui.
  
 
### Diagramas
 
<figure class="image"> 
 <p align = "center"> 
  <img src="https://github.com/tdsh-ux/dataBases/blob/master/models/conceptualModel.jpeg">
  <br>
    <em>Figura 1: Modelo Conceitual.</em> 
 </p> 
  <p align = "center"> 
  <img src="https://github.com/tdsh-ux/dataBases/blob/master/models/logicModel.jpeg">
  <br>
    <em>Figura 2: Modelo Lógico.</em> 
 </p> 
  <p align = "center"> 
  <img src="https://github.com/tdsh-ux/dataBases/blob/master/models/physicalModel.jpeg">
  <br>
    <em>Figura 3: Modelo Físico.</em> 
 </p> 

</figure> 
