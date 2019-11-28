class RentalAuthorizer
  def initialize(rental, user)
    @rental = rental
    @user = user
  end

  def authorized?
    admin? || employee?
  end

  private

  attr_reader :rental, :user

  def admin?
    user.admin?
  end

  def employee?
    rental.subsidiary.eql?(user.subsidiary)
  end
end
