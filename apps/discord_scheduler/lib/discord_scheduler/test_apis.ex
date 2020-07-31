defmodule DiscordScheduler.TestApis do
  @moduledoc """
  The TestApis context.
  """

  import Ecto.Query, warn: false
  alias DiscordScheduler.Repo

  alias DiscordScheduler.TestApis.TestApi

  @doc """
  Returns the list of testapis.

  ## Examples

      iex> list_testapis()
      [%TestApi{}, ...]

  """
  def list_testapis do
    Repo.all(TestApi)
  end

  @doc """
  Gets a single test_api.

  Raises `Ecto.NoResultsError` if the Test api does not exist.

  ## Examples

      iex> get_test_api!(123)
      %TestApi{}

      iex> get_test_api!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test_api!(id), do: Repo.get!(TestApi, id)

  @doc """
  Creates a test_api.

  ## Examples

      iex> create_test_api(%{field: value})
      {:ok, %TestApi{}}

      iex> create_test_api(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test_api(attrs \\ %{}) do
    %TestApi{}
    |> TestApi.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test_api.

  ## Examples

      iex> update_test_api(test_api, %{field: new_value})
      {:ok, %TestApi{}}

      iex> update_test_api(test_api, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test_api(%TestApi{} = test_api, attrs) do
    test_api
    |> TestApi.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TestApi.

  ## Examples

      iex> delete_test_api(test_api)
      {:ok, %TestApi{}}

      iex> delete_test_api(test_api)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test_api(%TestApi{} = test_api) do
    Repo.delete(test_api)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test_api changes.

  ## Examples

      iex> change_test_api(test_api)
      %Ecto.Changeset{source: %TestApi{}}

  """
  def change_test_api(%TestApi{} = test_api) do
    TestApi.changeset(test_api, %{})
  end
end
