# Данный Makefile я писал для себя. Впрочем, Вы можете его сконфигурировать под свою машину.
# Не забудьте установить все необходимые утилиты и записать их в PATH по необходимости 

# Для развертывания в одну команду
QGIS_PLUGINS_HOME = C:\Users\NOOB\AppData\Roaming\QGIS\QGIS3\profiles\default\python\plugins

# Название папеи
PLUGIN_NAME = hostplugin

#Исходный код Tensorflow можно получить из репозитория https://github.com/tensorflow/tensorflow.git
.PHONY: all build zip deploy clean all-dev build-dev clean-dev zip-dev deploy-dev

all: build

all-dev: build-dev

build: clean
	@echo start Check .build
	if not exist ".build" mkdir ".build"
	
	@echo start copying "$(PLUGIN_NAME)" dir
	xcopy "$(PLUGIN_NAME)" ".build\$(PLUGIN_NAME)" /E /H /D /R /Y /I

	@echo start copying "embedded-python" dir
	xcopy "embedded-python" ".build\$(PLUGIN_NAME)\embedded-python" /E /H /D /R /Y /I

	@echo start copying "embedded-python-kernel" dir
	xcopy "embedded-python-kernel" ".build\$(PLUGIN_NAME)\embedded-python-kernel" /E /H /D /R /Y /I

build-dev: clean-dev
	@echo start Check .build
	if not exist ".build" mkdir ".build"

	@echo start copying "$(PLUGIN_NAME)" dir
	xcopy "$(PLUGIN_NAME)" ".build\$(PLUGIN_NAME)" /E /H /D /R /Y /I

	@echo start copying "embedded-python-kernel" dir
	xcopy "embedded-python-kernel" ".build\$(PLUGIN_NAME)\embedded-python-kernel" /E /H /D /R /Y /I

clean:
	if exist ".build" rd ".build" /S /Q

clean-dev:
	for %%f in ("build\"*) do if not "%%f" == "embedded-python" del "%%f"

zip: build
	7z a ".build\hostedplugin.zip" ".build\*"

zip-dev: build-dev
	7z a ".build\hostedplugin.zip" ".build\*"

deploy: build
	@echo start copying "embedded-python" dir
	xcopy ".build\hostedplugin" "$(QGIS_PLUGINS_HOME)\embedded-python" /E /H /D /R /Y /I


deploy-dev: build-dev
	@echo start copying "embedded-python" dir
	xcopy "embedded-python" ".build\hostplugin\embedded-python" /E /H /D /R /Y /I

	@echo start copying "embedded-python-kernel" dir
	xcopy "embedded-python-kernel" ".build\hostplugin\embedded-python-kernel" /E /H /D /R /Y /I