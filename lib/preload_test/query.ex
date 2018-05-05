defmodule Query do
  import Ecto.Query
  alias PreloadTest.Comment
  alias PreloadTest.Tag
  alias PreloadTest.Post

  def preload_comments() do
    comment_fn = fn post_ids ->
      from(c in Comment,
        where: c.post_id in (^post_ids))
      |> PreloadTest.Repo.all()
    end

    from p in Post,
      preload: [comments: ^comment_fn]
  end

  def preload_post_tags() do
    post_tag_fn = fn post_ids ->
      from(t in Tag,
        inner_join: pt in "post_tags", on: t.id == pt.tag_id,
        where: pt.post_id in (^post_ids),
        select: %{t | post_id: pt.post_id})
      |> PreloadTest.Repo.all()
    end

    from p in Post,
      preload: [post_tags: ^post_tag_fn]
  end

  def preload_comment_tags() do
    comment_tag_fn = fn post_ids ->
      from(t in Tag,
        inner_join: c in Comment, on: t.comment_id == c.id,
        where: c.post_id in (^post_ids),
        select: %{t | post_id: c.post_id})
      |> PreloadTest.Repo.all()
    end

    from p in Post,
      preload: [comment_tags: ^comment_tag_fn]
  end
end

