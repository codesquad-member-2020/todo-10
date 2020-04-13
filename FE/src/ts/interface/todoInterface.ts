interface ITodoViewTemplate {
    id: string;
    title: string;
    content: string;
    cards: [];
    sections: [];
}

interface ICardOption {
    dragTarget: Node | HTMLElement | null;
    targetHeight: number | null;
    toTarget: Node | HTMLElement | null;
    toTargetWrap: Node | HTMLElement | null;
    prevColumn: Node | HTMLElement | null;
    currColumn: Node | HTMLElement | null;
}

export {
    ITodoViewTemplate,
    ICardOption,
}