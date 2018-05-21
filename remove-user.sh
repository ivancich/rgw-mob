#!/bin/sh

radosgw-admin subuser rm --uid=janedoe:swift

radosgw-admin user rm --uid=janedoe
