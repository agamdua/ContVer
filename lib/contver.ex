defmodule ContVer do

  @doc """
  Returns yaml file as elixir data structure
  """
  def get_release_config(filepath) do
    config = YamlElixir.read_from_file(filepath)
  end

  @doc """
  Retrieves semantics from file
  """
  def get_semantics(release_config) do
    Enum.at(release_config, 0)["semantics"]
  end

  @doc """
  Updates release version in config
  """
  def bump_version(semantics) do
  end

  def bring_everything_together(filepath) do
    config = get_release_config(filepath)
    semantics = get_semantics(config)
    new_version = bump_version(semantics)
  end
end
