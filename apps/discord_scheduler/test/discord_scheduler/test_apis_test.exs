defmodule DiscordScheduler.TestApisTest do
  use DiscordScheduler.DataCase

  alias DiscordScheduler.TestApis

  describe "testapis" do
    alias DiscordScheduler.TestApis.TestApi

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def test_api_fixture(attrs \\ %{}) do
      {:ok, test_api} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TestApis.create_test_api()

      test_api
    end

    test "list_testapis/0 returns all testapis" do
      test_api = test_api_fixture()
      assert TestApis.list_testapis() == [test_api]
    end

    test "get_test_api!/1 returns the test_api with given id" do
      test_api = test_api_fixture()
      assert TestApis.get_test_api!(test_api.id) == test_api
    end

    test "create_test_api/1 with valid data creates a test_api" do
      assert {:ok, %TestApi{} = test_api} = TestApis.create_test_api(@valid_attrs)
      assert test_api.title == "some title"
    end

    test "create_test_api/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TestApis.create_test_api(@invalid_attrs)
    end

    test "update_test_api/2 with valid data updates the test_api" do
      test_api = test_api_fixture()
      assert {:ok, %TestApi{} = test_api} = TestApis.update_test_api(test_api, @update_attrs)
      assert test_api.title == "some updated title"
    end

    test "update_test_api/2 with invalid data returns error changeset" do
      test_api = test_api_fixture()
      assert {:error, %Ecto.Changeset{}} = TestApis.update_test_api(test_api, @invalid_attrs)
      assert test_api == TestApis.get_test_api!(test_api.id)
    end

    test "delete_test_api/1 deletes the test_api" do
      test_api = test_api_fixture()
      assert {:ok, %TestApi{}} = TestApis.delete_test_api(test_api)
      assert_raise Ecto.NoResultsError, fn -> TestApis.get_test_api!(test_api.id) end
    end

    test "change_test_api/1 returns a test_api changeset" do
      test_api = test_api_fixture()
      assert %Ecto.Changeset{} = TestApis.change_test_api(test_api)
    end
  end
end
