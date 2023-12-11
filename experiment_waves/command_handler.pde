String path_prefix = sketchPath("../Users/catamon/Documents/MAS.834/experiment_waves/");
String python_path = "../Library/Frameworks/Python.framework/Versions/3.11/bin/python3";
String ffmpeg_path = "/opt/homebrew/bin/ffmpeg";

void run_command(String[] cmd){
  try {
    Process process = Runtime.getRuntime().exec(cmd);
    
    // Create a BufferedReader to read the combined output (stdout and stderr)
    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
    String line;
    
    // Read and print each line of the combined output
    while ((line = reader.readLine()) != null) {
        System.out.println(line);
    }
    
    // Create a BufferedReader to read the standard error (stderr) separately
    BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
    
    // Read and print each line of the standard error (stderr)
    while ((line = errorReader.readLine()) != null) {
        System.err.println(line);
    }
    
    // Wait for the process to complete
    int exitCode = process.waitFor();
    
    // Check the exit code to determine if the process completed successfully
    if (exitCode == 0) {
        System.out.println("Python script executed successfully.");
    } else {
        System.err.println("Python script encountered an error. Exit code: " + exitCode);
        println(reader);
        println("alo");
    }
} catch (IOException | InterruptedException e) {
    // Handle the exception, e.g., print an error message or take appropriate action.
    e.printStackTrace();
}
}


void create_time_folder(){
   String[] cmd = {"/bin/bash", path_prefix + "create_folder.sh", formattedDateTime, path_prefix, python_path};
   run_command(cmd);
  
}

void save_video(){
     String[] cmd = {"/bin/bash", path_prefix + "save_video.sh", formattedDateTime, path_prefix, ffmpeg_path};
     run_command(cmd);

}
