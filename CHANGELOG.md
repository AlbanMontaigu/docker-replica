
## 3.0.0 (2017-09-14)
- UPDATE: bump to version 3.0.0 and **will not follow unison version anymore** since it's not the only one component
- UPDATE: base image changed to linux alpine 3.6
- UPDATE: more documentation in the readme
- UPDATE: old Makefile removed since there is a CI
- UPDATE: now log to stdout for replica-master
- FEATURE: CircleCI 2.0 added for replica-master
- FEATURE: replica master tests added
- FEATURE: CircleCI 2.0 added for replica-slave
- FEATURE: replica slave tests added
- FEATURE: ability to add a `SYNC_PATHS` file at the root of the `REPLICA_DATA_DIR` do sync only specified path
- FEATURE: `UNISON_PRF_REPEAT` var added to set unison repeat value in profile path

## 2.48.4 (2016-10-16)
- Update to unison 2.48.4
- URL fixed
