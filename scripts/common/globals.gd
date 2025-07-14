class_name Globals
extends Node


signal card_changed_pile(card: Card, pile: Pile)
signal enemy_dead(character: Character)

signal remove_from_hand(card_ui: CardUI)

signal discard_card(card: Card)
signal exhaust_card(card: Card)
signal drawn_card(card: Card)
