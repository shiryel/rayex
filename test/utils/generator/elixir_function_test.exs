defmodule Utils.Generator.ElixirFunctionTest do
  use ExUnit.Case

  alias Utils.Generator.ElixirFunction

  describe "core" do
    test "r(void) p(int, const char *)" do
      input =
        "void InitWindow(int width, int height, const char *title);              // Initialize window and OpenGL context"

      return = """
        @doc "Initialize window and OpenGL context"
        @type init_window(integer(), integer(), String.t()) :: :ok
        def init_window(width, height, title),
          do: raise("NIF init_window not implemented")
      """

      assert return == ElixirFunction.parser(input)
    end

    test "r(bool) p(void)" do
      input =
        "bool WindowShouldClose(void);                                           // Check if KEY_ESCAPE pressed or Close icon pressed"

      return = """
        @doc "Check if KEY_ESCAPE pressed or Close icon pressed"
        @type window_should_close :: boolean()
        def window_should_close,
          do: raise("NIF window_should_close not implemented")
      """

      assert return == ElixirFunction.parser(input)
    end

    test "r(unsigned char *) p(unsigned int *)" do
      input =
        "unsigned char *LoadFileData(const char *fileName, unsigned int *bytesRead);     // Load file data as byte array (read)"

      return = """
        @doc "Load file data as byte array (read)"
        @type load_file_data(String.t(), pos_integer()) :: String.t()
        def load_file_data(file_name, bytes_read),
          do: raise("NIF load_file_data not implemented")
      """

      assert return == ElixirFunction.parser(input)
    end

    test "r(const char *) p(const char *)" do
      input =
        ~S|const char *GetFileExtension(const char *fileName);                     // Get pointer to extension for a filename string (includes dot: ".png")|

      return = """
        @doc "Get pointer to extension for a filename string (includes dot: ".png")"
        @type get_file_extension(String.t()) :: String.t()
        def get_file_extension(file_name),
          do: raise("NIF get_file_extension not implemented")
      """

      assert return == ElixirFunction.parser(input)
    end

    test "r(char **) p(const char *, int *)" do
      input =
        ~S|char **GetDirectoryFiles(const char *dirPath, int *count);              // Get filenames in a directory path (memory should be freed)|

      return = """
        @doc "Get filenames in a directory path (memory should be freed)"
        @type get_directory_files(String.t(), integer()) :: String.t()
        def get_directory_files(dir_path, count),
          do: raise("NIF get_directory_files not implemented")
      """

      assert return == ElixirFunction.parser(input)
    end

    test "r(Rectangle) p(Rectangle, Rectangle)" do
      input =
        ~S|Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                          // Get collision rectangle for two rectangles collision|

      return = """
        @doc "Get collision rectangle for two rectangles collision"
        @type get_collision_rec(rectangle(), rectangle()) :: rectangle()
        def get_collision_rec(rec1, rec2),
          do: raise("NIF get_collision_rec not implemented")
      """

      assert return == ElixirFunction.parser(input)
    end
  end
end
