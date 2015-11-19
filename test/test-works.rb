require 'simplecov'
SimpleCov.start
if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require "lagotto-rb"
require 'fileutils'
require "test/unit"
require "json"

class TestWorks < Test::Unit::TestCase

  def setup
    @id = 'http://doi.org/10.15468/DL.SQNY5P'
  end

  def test_works
    res = Lagotto.works(ids: @id, instance: "crossref")
    assert_equal(2, res.length)
    assert_equal(Hash, res.class)
    assert_equal(Array, res['works'].class)
  end

end
