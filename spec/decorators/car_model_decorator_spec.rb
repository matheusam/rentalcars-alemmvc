require 'rails_helper'

describe CarModelDecorator do
  describe '#photo' do
    it 'should render image if not present' do
      car_model = build(:car_model)

      expect(car_model.decorate.photo).to eq('https://via.placeholder.com/150x150')
    end

    it 'should render image if attached' do
      car_model = build(:car_model)
      # fazer attach do active storage
      car_model.photo.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', '150x150.png')),
        filename: '150x150.png'
      )

      # matcher de enum be_ NOME
      expect(car_model.decorate.photo).to be_attached
    end
  end

  describe '#car_options' do
    it 'should return an array of car options' do
      car_model = build(:car_model, car_options: 'janela,porta')

      expect(car_model.decorate.car_options).to include('janela')
      expect(car_model.decorate.car_options).to include('porta')
      expect(car_model.decorate.car_options.count).to eq(2)
    end

    it 'should return an empty array' do
      car_model = build(:car_model, car_options: nil).decorate

      expect(car_model.car_options).to be_empty
    end
  end
end
