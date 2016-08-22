defmodule ContverTest do
  use ExUnit.Case
  doctest ContVer

  test "read release.yml okay" do
    config = ContVer.get_release_config("test/example-release.yml")
    assert Enum.at(config, 0)["semantics"]
  end

  test "read bring everything together" do
    new_version = ContVer.bring_everything_together("test/example-release.yml")
    refute new_version  # not implemented yet
  end
end
