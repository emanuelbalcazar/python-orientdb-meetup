--usando select
select nombre, out('dicta') from `Profesor`
select nombre, out('dicta').in('matriculadoEn') from `Profesor`
select nombre, out('dicta').in('matriculadoEn') as alumnoMatriculado from `Profesor`
select nombre, out('dicta').in('matriculadoEn').nombre as alumnoMatriculado from `Profesor`

--usando match
match {class:Profesor, as: profesor} return profesor
match {class:Profesor, as: profesor, where: (nombre='Samuel')} return profesor
match {class:Profesor, as: profesor, where: (nombre='Merlin')}.out('dicta'){as: cur} return cur
match {class:Profesor, as: profesor, where: (nombre='Merlin')}.out('dicta').in('matriculadoEn'){as:alu} return alu

--ahora agregamos $elements
match {class:Profesor, as: profesor, where: (nombre='Merlin')}.out('dicta').in('matriculadoEn'){as:alu} return $elements

--ahora agregamos $pathelements
match {class:Profesor, as: profesor, where: (nombre='Merlin')}.out('dicta').in('matriculadoEn'){as:alu} return $pathelements
