configure :development do
  set :database, "sqlite3:///database.db"
end

configure :production do
  db = URI.parse(ENV['postgres://zmemoijynaclwq:kzAA8S0rOzrsi_BxbwZPpE3ZHn@ec2-54-163-245-162.compute-1.amazonaws.com:5432/dm636c9fkgilk'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end
