# db-view
database utility

# required
j2ee container

# try
download db-view.war and deploy it on your j2ee container.

or access herokapp 

https://db-view.herokuapp.com/

# customize presets of jdbc login parameters 
modify presets array in the index.jsp
then presets of jdbc login parameters will be shown in the databases selectbox.

# customize css 

db-view includes 3 css as default.
if you want to use customized css.
please add your costomized css into the css directory,then your css will be shown in the theme selectbox.

#note
db-view.war does not include oracle jdbc.jar

To run the build.xml requires correct path to the "servlet-api.jar"
