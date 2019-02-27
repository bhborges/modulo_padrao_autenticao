class Ability
  include CanCan::Ability

  def initialize(user)
    def initialize(usuario)
      #permissao_por_perfil(usuario)
      permissoes = Permissao.por_usuario(usuario.id)
      permissoes.each do |permissao|
        if permissao[:recurso_nome].to_sym == :todos
          can :manage, :all
        end
        nome_recurso = permissao[:recurso_tipo].to_s == 'simbolo' ? permissao[:recurso_nome].to_sym : permissao[:recurso_nome].to_s.constantize rescue permissao[:recurso_nome].to_s
        permissoes(permissao).each do |acao|
          can acao.to_sym, nome_recurso
        end
      end

    end

    def permissoes(permissao)
      permissoes = []
      permissoes << 'create' if permissao[:criar]
      permissoes << 'update' if permissao[:alterar]
      permissoes << 'delete' if permissao[:excluir]
      permissoes << 'read'   if permissao[:visualizar]
      if permissoes.size == 4
        permissoes = ['manage']
      else
        permissoes
      end
    end
  end
end
