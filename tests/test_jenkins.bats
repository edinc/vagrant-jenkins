#!/usr/bin/env bats

@test "Jenkins is installed" {
  run dpkg -l jenkins
  [ "$status" -eq 0 ]
}

@test "Jenkins service is running" {
  run systemctl is-active jenkins
  [ "$status" -eq 0 ]
  [ "$output" = "active" ]
}

@test "Jenkins is accessible on port 8080" {
  run curl -s -o /dev/null -w "%{http_code}" http://localhost:8080
  [ "$status" -eq 0 ]
  [ "$output" -eq 200 ]
}
