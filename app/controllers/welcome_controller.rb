class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "Curso de Ruby - Kauan"
    @meu_nome = params[:nome]
  end
end
