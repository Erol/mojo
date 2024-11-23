require "test_helper"

class ManagerTest < ActiveSupport::TestCase
  test "sample returns a random record" do
    manager = Manager.sample
    assert manager.present?
  end
end
