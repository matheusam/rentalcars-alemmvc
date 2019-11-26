class CarModelDecorator < Draper::Decorator
  delegate_all #faz o delegate automatico pra classe

  def photo
    'https://via.placeholder.com/150x150'
  end
end
