defmodule PreloadTest.MainTest do
  use PreloadTest.DataCase

  describe "posts" do

    @post_attrs %{name: "some name"}
    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@post_attrs)
        |> fn attr -> PreloadTest.Post.changeset(%PreloadTest.Post{}, attr) end.()
        |> PreloadTest.Repo.insert()

      post
    end

    @comment_attrs %{name: "comment"}
    def comment_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@comment_attrs)
        |> fn attr -> PreloadTest.Comment.changeset(%PreloadTest.Comment{}, attr) end.()
        |> PreloadTest.Repo.insert()

      tag
    end

    @tag_attrs %{tag: "tag"}
    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@tag_attrs)
        |> fn attr -> PreloadTest.Tag.changeset(%PreloadTest.Tag{}, attr) end.()
        |> PreloadTest.Repo.insert()

      tag
    end

    def post_tag_fixture(attrs \\ %{}) do
      {:ok, post_tag} =
        PreloadTest.PostTag.changeset(%PreloadTest.PostTag{}, attrs)
        |> PreloadTest.Repo.insert()

      post_tag
    end

    test "preload has_many" do
      p = post_fixture()
      comment_fixture(%{post_id: p.id})
      comment_fixture(%{post_id: p.id})

      [p] = Query.preload_comments() |> PreloadTest.Repo.all()
      assert 2 == length(p.comments)
    end

    test "preload many_to_many" do
      p = post_fixture()
      t1 = tag_fixture()
      t2 = tag_fixture()
      post_tag_fixture(%{post_id: p.id, tag_id: t1.id})
      post_tag_fixture(%{post_id: p.id, tag_id: t2.id})

      [p] = Query.preload_post_tags() |> PreloadTest.Repo.all()
      assert 2 == length(p.post_tags)
    end

    test "preload has_many through" do
      p = post_fixture()
      c = comment_fixture(%{post_id: p.id})
      tag_fixture(%{comment_id: c.id})
      tag_fixture(%{comment_id: c.id})

      [p] = Query.preload_comment_tags() |> PreloadTest.Repo.all()
      assert 2 == length(p.comment_tags)
    end

  end
end
