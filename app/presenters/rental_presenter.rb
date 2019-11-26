class RentalPresenter < SimpleDelegator
  #attr_reader :rental
  # pode remover os objetos ja que o SimpleDelegator manda pra classe pai

  #delega metodos de helpers para nao ter que colocar helper. em tudo
  delegate :content_tag, to: :helper

  # nao precisa do super se usar o SimpleDelegator

  #def initialize(rental)
    #@rental = rental
  #  super(rental)
  #end

  def status_badge
    # objeto helper do rails
    #helper.content_tag :span, class: "badge badge-#{rental.status}" do
    content_tag :span, class: "badge badge-#{status}" do
      I18n.t(status)
    end
  end

  private

  def helper
    # carrega todos metodos disponiveis dos helper para os controller
    @helper ||= ApplicationController.helpers
  end

  # para metodos faltando pode se sobreescrever o method_missing e mandar um
  # send para o objeto
  # ou usa o simple delagator
end
