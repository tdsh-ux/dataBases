# Disciplina: Base de Dados
<style>
 figure {
    display: inline-block;
    border: 1px dotted gray;
    margin: 20px; /* adjust as needed */
}
figure img {
    vertical-align: top;
}
figure figcaption {
    border: 1px dotted blue;
    text-align: center;
}
</style> 
Repositório com os arquivos para a avaliação continuada da disciplina Base de Dados, ministrada remotamente na Escola de Matemática Aplicada (EMAp) pelo professor Renato Souza. 

A avaliação é dividida em duas partes. Em um momento inicial, tínhamos de mapear um conjunto de dados e realizar sua modelagem, gerando, enfim, um dump em formato SQL. Nesse sentido, escolhemos os dados do projeto [What's on the menu?](https://data.world/data-society/discover-the-menu), em que foram catalogados os menus de restaurantes ocidentais de 1850 a 2015. 


A partir da base de dados, a organização do repositório é a seguinte: em [data](https://github.com/tdsh-ux/dataBases/tree/master/data), estão as bases de dados brutas (para o push, foi utilizado o [Git Large File Storage](https://git-lfs.github.com/)). Em [RScriptsCleaning](https://github.com/tdsh-ux/dataBases/tree/master/RScriptsCleaning), estão os scripts em R para [download](https://github.com/tdsh-ux/dataBases/blob/master/RScriptsCleaning/dishScript.R) e [limpeza](https://github.com/tdsh-ux/dataBases/blob/master/RScriptsCleaning/menuScript.R) dos dados. As tabelas preparadas, então, estão em [modelData](https://github.com/tdsh-ux/dataBases/tree/master/modelData). Em seguida, foi utilizado, conforme está em [PythonScriptsToSQL](https://github.com/tdsh-ux/dataBases/tree/master/PythonScriptsToSQL), um [notebook](https://github.com/tdsh-ux/dataBases/blob/master/PythonScriptsToSQL/dumpScript.ipynb) de Python para inserir os dados na base de dados MySQL e gerar o dump em formato SQL. Este, enfim, foi inserido em [dump](https://github.com/tdsh-ux/dataBases/blob/master/PythonScriptsToSQL/dumpScript.ipynb). 
 
<figure class="image">
  <img src="https://github.com/tdsh-ux/dataBases/blob/master/models/conceptualModel.jpeg">
  <figcaption >Figura 1: Modelo Conceitual</figcaption>
</figure>
