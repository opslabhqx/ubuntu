# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

# renovate: datasource=docker depName=ubuntu
ARG BASE_VERSION=noble@sha256:dfc10878be8d8fc9c61cbff33166cb1d1fe44391539243703c72766894fa834a

FROM ubuntu:${BASE_VERSION} AS base

USER root
