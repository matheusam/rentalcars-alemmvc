require 'rails_helper'

describe RentalCategoryAndSubsidiaryQuery do
  context '.call' do
    it 'should work' do
      subsidiary = create(:subsidiary, name: 'Almeida Motors')
      other_subsidiary = create(:subsidiary, name: 'Vasco Motors')

      category_a = create(:category, name: 'A', daily_rate: 100, car_insurance: 200,
                        third_party_insurance: 200)
      category_b = create(:category, name: 'B', daily_rate: 50, car_insurance: 100,
                        third_party_insurance: 100)
      category_c = create(:category, name: 'C', daily_rate: 25, car_insurance: 50,
                        third_party_insurance: 50)

      customer = create(:individual_client, name: 'Claudionor',
                      cpf: '318.421.176-43', email: 'cro@email.com')

      create_list(:car, 10, category: category_a)
      create_list(:car, 10, category: category_b)

      create(:rental, category: category_a, subsidiary: subsidiary,
                      start_date: '2019-01-08', end_date: '2019-01-10',
                      client: customer, price_projection: 100, status: :scheduled)

      create(:rental, category: category_b, subsidiary: subsidiary,
                      start_date: '2019-01-02', end_date: '2019-01-13',
                      client: customer, price_projection: 100, status: :scheduled)

      create(:rental, category: category_a, subsidiary: other_subsidiary,
                      start_date: '2019-01-08', end_date: '2019-01-15',
                      client: customer, price_projection: 100, status: :scheduled)

      create(:rental, category: category_b, subsidiary: other_subsidiary,
                      start_date: '2018-12-08', end_date: '2019-01-10',
                      client: customer, price_projection: 100, status: :scheduled)

      create(:rental, category: category_a, subsidiary: subsidiary,
                      start_date: '2019-01-14', end_date: '2019-01-24',
                      client: customer, price_projection: 100, status: :scheduled)

      start = '2018-12-01'
      finish = '2019-02-01'

      results = described_class.new(start, finish).call

      expect(results.first['subsidiary']).to eq 'Almeida Motors'
      expect(results.first['category']).to eq 'A'
      expect(results.first['total']).to eq 2

      puts results
    end
  end
end
