import { PageHeader } from "antd";
import React from "react";

// displays a page header

export default function Header() {
  return (
    <a href="https://github.com/ABossOfMyself/Decentralized-Staking.git" target="_blank" rel="noopener noreferrer">
      <PageHeader
        title="🥩 Decentralized Staking Dapp"
        style={{ cursor: "pointer" }}
      />
    </a>
  );
}
