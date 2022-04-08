inherit core-image
IMAGE_INSTALL:append = " aesd-assignments"
CORE_IMAGE_EXTRA_INSTALL += " openssh"
inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P root root;"
