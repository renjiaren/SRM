import time


class ModelRegenerate:
    def __init__(self, Temp_path: str, model_path: str, model_name: str, t: int, *args):
        self.Temp_path = Temp_path
        self.model_path = model_path
        self.model_name = model_name
        self.t = t
        self.parameterSet = args

    def command_is_ready(self):
        with open(self.Temp_path + "CreoCommandReady.txt", "w") as file:
            file.write("")
        file.close()
        time.sleep(self.t)

    def model_load(self):
        with open(self.Temp_path + "CreoCommand.txt", "w") as file:
            file.write("LOAD_MODEL" + "\n" + self.model_path + self.model_name)
        file.close()
        time.sleep(self.t)
        self.command_is_ready()

    def SET_PARAMT_REGEN(self):
        with open(self.Temp_path + "CreoCommand.txt", "w") as file:
            file.write("SET_PARAMT_REGEN" + "\n")
        file.close()
        time.sleep(self.t)
        with open(self.Temp_path + "CreoCommand.txt", "a") as file:
            num = int(len(self.parameterSet) / 2)
            for i in range(num):
                file.write(str(self.parameterSet[i]) + "=" + str(self.parameterSet[i + num]) + '\n')
        file.close()
        time.sleep(self.t)
        self.command_is_ready()
    # def model_parameter_regenerate(self, para_name, para_value):

    def model_save(self):
        with open(self.Temp_path + "CreoCommand.txt", "w") as file:
            file.write("SAVE_MODEL" + "\n")
        file.close()
        time.sleep(self.t)
        self.command_is_ready()

    def model_export_sat(self):
        with open(self.Temp_path + "CreoCommand.txt", "w") as file:
            file.write("EXPORT_MODEL_SAT" + "\n" + self.model_path + self.model_name)
        file.close()
        time.sleep(self.t)
        self.command_is_ready()

    def stop(self):
        with open(Temp_path + "CreoCommand.txt", "w") as file:
            file.write("STOP" + "\n")
        file.close()
        time.sleep(self.t)
        self.command_is_ready()

    def execute(self):
        self.model_load()
        self.SET_PARAMT_REGEN()
        self.model_save()
        self.model_export_sat()
