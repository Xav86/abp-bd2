<?php
require __DIR__ . '/../config/db.php';

$acao = $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                                                                                                                                                                                                                                                                                                                                                                                                                          
    $id = $_POST['id'] ?? null;
    $placa = $_POST['placa'] ?? null;
    $modelo = $_POST['modelo'] ?? null;
    $marca = $_POST['marca'] ?? null;
    $ano_fabricacao = $_POST['ano_fabricacao'] ?? null;
    $chassi = $_POST['chassi'] ?? null;
    $quilometragem = $_POST['quilometragem'] ?? null;

    if ( !$placa || !$modelo || !$marca || !$ano_fabricacao || !$chassi || !$quilometragem ) {
        die('Preencha todos os campos obrigatórios!');
    }

    if ($acao === 'add') {

        $stmt = $pdo->prepare("INSERT INTO veiculos (
            placa, modelo, marca, ano_fabricacao, chassi, quilometragem
        ) VALUES (
             :placa, :modelo, :marca, :ano_fabricacao, :chassi, :quilometragem
        )");

        $stmt->execute([
            ':placa' => $placa,
            ':modelo' => $modelo,
            ':marca' => $marca,
            ':ano_fabricacao' => $ano_fabricacao,
            ':chassi' => $chassi,
            ':quilometragem' => $quilometragem,
        ]);

        echo "Veículo cadastrado com sucesso!";

    } elseif ($acao === 'edit' && $id) {

        $stmt = $pdo->prepare("UPDATE veiculos SET 
            placa = :placa, modelo = :modelo, marca = :marca,
            ano_fabricacao = :ano_fabricacao, chassi = :chassi, quilometragem = :quilometragem
            WHERE id = :id");

        $stmt->execute([
            ':placa' => $placa,
            ':modelo' => $modelo,
            ':marca' => $marca,
            ':ano_fabricacao' => $ano_fabricacao,
            ':chassi' => $chassi,
            ':quilometragem' => $quilometragem,
            ':id' => $id
        ]);

        echo "Veículo atualizado com sucesso!";
    } else {
        echo "Ação inválida ou ID ausente.";
    }
}


if ($acao === 'delete') {
    $id = $_GET['id'] ?? null;
    if (!$id) {
        die('ID inválido');
    }

    try {
        $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM Ordens_de_Servico WHERE id_veiculo = ?");
        $checkStmt->execute([$id]);
        $count = $checkStmt->fetchColumn();

        if ($count > 0) {
            die("Não é possível deletar: existem ordens de serviço vinculadas a este veículo.");
        }

        $stmt = $pdo->prepare("DELETE FROM veiculos WHERE id = ?");
        $stmt->execute([$id]);

        echo "Registro deletado com sucesso";
        exit;

    } catch (PDOException $e) {
        die("Erro ao deletar: " . $e->getMessage());
    }
}

?>