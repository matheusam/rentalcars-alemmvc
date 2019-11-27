class CarModelDecorator < Draper::Decorator
  delegate_all #faz o delegate automatico pra classe

  def photo
    return super if super.attached?

    'https://via.placeholder.com/150x150'
  end

  def car_options
    # super == object.car_options (apenas no draper)
    return [] if super.blank?

    super.split(',')
  end
end
