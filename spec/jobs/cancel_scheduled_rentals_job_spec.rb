require 'rails_helper'

describe CancelScheduledRentalsJob do
  describe '.auto_enqueue' do
    it 'enqueue itself' do
      described_class.auto_enqueue(Time.zone.now)

      # work_off metodo do delayed job para executar testes, outros
      # adaptadores também tem comandos similares
      expect(Delayed::Worker.new.work_off).to eq([1, 0])
    end
  end

  describe '.perform' do
    it 'should cancel overpast rentals' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')

      category = create(:category, name: 'A', daily_rate: 100, car_insurance: 200,
                        third_party_insurance: 200)

      customer = create(:individual_client, name: 'Claudionor',
                      cpf: '318.421.176-43', email: 'cro@email.com')

      create_list(:car, 10, category: category)

      old_rental = create(:rental, category: category, subsidiary: subsidiary,
                                   start_date: 10.days.ago,
                                   end_date: 2.days.ago,
                                   client: customer, price_projection: 100,
                                   status: :scheduled)

     future_rental = create(:rental, category: category, subsidiary: subsidiary,
                                  start_date: 1.days.from_now,
                                  end_date: 10.days.from_now,
                                  client: customer, price_projection: 100,
                                  status: :scheduled)

     described_class.auto_enqueue(Time.zone.now)

     Delayed::Worker.new.work_off
     old_rental.reload
     future_rental.reload

     expect(future_rental).to be_scheduled
     expect(old_rental).to be_canceled
    end
  end
end
