require_relative 'helper'

class Scorm2004Test < ActiveSupport::TestCase
  context 'Scorm2004' do
    should 'be a module' do
      assert_kind_of Module, Scorm2004
    end
  end
end
