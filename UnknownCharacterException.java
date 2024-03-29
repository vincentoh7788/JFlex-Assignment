/*
 * Copyright 2020, Gerwin Klein, Régis Décamps, Steve Rowe
 * SPDX-License-Identifier: GPL-2.0-only
 */


class UnknownCharacterException extends Exception {
  UnknownCharacterException(String unknownInput) {
    super("Unknown character « " + unknownInput + " »");
  }
}
