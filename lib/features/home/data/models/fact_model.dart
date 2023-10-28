// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cat_facts/features/home/domain/entities/fact_entity.dart';

class FactModel {
  String? fact;
  int? length;

  FactModel({
    this.fact,
    this.length,
  });

  FactModel copyWith({
    String? fact,
    int? length,
  }) {
    return FactModel(
      fact: fact ?? this.fact,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fact': fact,
      'length': length,
    };
  }

  factory FactModel.fromMap(Map<String, dynamic> map) {
    return FactModel(
      fact: map['fact'] as String,
      length: map['length'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FactModel.fromJson(String source) =>
      FactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FactModel(fact: $fact, length: $length)';

  @override
  bool operator ==(covariant FactModel other) {
    if (identical(this, other)) return true;

    return other.fact == fact && other.length == length;
  }

  @override
  int get hashCode => fact.hashCode ^ length.hashCode;

  FactEntity toEntity() => FactEntity(fact: fact, length: length);
}
