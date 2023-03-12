const presets = [
  ["", "", "", "", ""],
  [
    "mysql-heroku", 
    "com.mysql.jdbc.Driver", 
    "jdbc:mysql://us-cdbr-iron-east-02.cleardb.net:3306/heroku_126abff0eac31c8", 
    "bf05d3bb2265c3", 
    "fc67f770"
  ],
  [
    "mysql-template", 
    "com.mysql.jdbc.Driver", 
    "jdbc:mysql:3306//localhost/database", 
    "user", 
    "password"
  ],
  [
    "postgres-template", 
    "org.postgresql.Driver", 
    "jdbc:postgresql:5432//localhost/database", 
    "user", 
    "password"],
];

function loadPresets() {
  for (var i = 0; i < presets.length; i++) {
    $("#presets").append($("<option>").html(presets[i][0]).val(i));
  }
}