require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe '#rental_status' do
    xit 'should render green color when finalized' do
      rental = build(:rental, status: :finalized)

      result = helper.rental_status(rental)

      expect(result).to eq('<span class="badge badge-finalized">Finalizada</span>')
    end

    xit 'should render blue color when ongoing' do
      rental = build(:rental, status: :ongoing)

      result = helper.rental_status(rental)

      expect(result).to eq('<span class="badge badge-ongoing">Em andamento</span>')
    end
  end
end
