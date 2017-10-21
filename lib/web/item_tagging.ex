defmodule Web.ItemTagging do
  @moduledoc """
  Bounded context for the Phoenix app talking to the data layer
  """

  alias Data.Item
  alias Data.ItemTagging
  alias Data.Repo
  alias Game.Items

  @doc """
  Get a single item
  """
  @spec get(id :: integer) :: ItemTagging.t
  def get(id) do
    ItemTagging
    |> Repo.get(id)
  end

  @doc """
  Get a changeset for a new page
  """
  @spec new(item :: Item.t) :: changeset :: map
  def new(item), do: item |> Ecto.build_assoc(:item_taggings) |> ItemTagging.changeset(%{})

  @doc """
  Create an item tagging
  """
  @spec create(item :: Item.t, item_tag_id :: integer) :: {:ok, ItemTagging.t} | {:error, changeset :: map}
  def create(item, item_tag_id) do
    changeset =
      item
      |> Ecto.build_assoc(:item_taggings)
      |> ItemTagging.changeset(%{"item_tag_id" => item_tag_id})

    case changeset |> Repo.insert() do
      {:ok, item_tagging} ->
        Item
        |> Repo.get(item_tagging.item_id)
        |> Items.reload()

        {:ok, item_tagging}
      error -> error
    end
  end

  @doc """
  Delete an item tagging
  """
  def delete(item_tagging) do
    case item_tagging |> Repo.delete() do
      {:ok, item_tagging} ->
        Item
        |> Repo.get(item_tagging.item_id)
        |> Items.reload()

        {:ok, item_tagging}
      error -> error
    end
  end
end