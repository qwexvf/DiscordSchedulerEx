defmodule DiscordScheduler.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition
  # To add a thumbnail version:
  @versions [:original]

  # Override the bucket on a per definition basis:
  # def bucket do
  #   :custom_bucket_name
  # end

  # Whitelist file extensions:
  def validate({file, _}) do
     ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  # end

  # Override the persisted filenames:
  def filename(version, {file, scope}) do
    IO.inspect file
    file_name = Path.basename(file.file_name, Path.extname(file.file_name))
    IO.puts "path name #{file_name}"
    "#{scope.uuid}_#{version}_#{file_name}"
  end


  # Override the storage directory:
  def storage_dir(_version, {_file, scope}) do
    Application.app_dir(:discord_scheduler_web, "priv/static/images") <> "/uploads/#{scope.uuid}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
end
