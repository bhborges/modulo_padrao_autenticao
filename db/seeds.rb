# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
usuario = Usuario.create(email: 'borgesbruno@hotmail.com.br', password: 'b992058128')
perfil = Perfil.create(descricao: 'Adminstrador')
UsuarioPerfil.create(usuario_id: usuario.id, perfil_id: perfil.id)
recurso = Recurso.create(nome: 'todos', descricao: 'Todos(*)', tipo: 'simbolo')
Permissao.create(perfil_id: perfil.id, recurso_id: recurso.id, criar: true, atualizar: true, excluir: true, visualizar: true)
